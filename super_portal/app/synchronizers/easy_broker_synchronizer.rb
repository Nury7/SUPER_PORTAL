require 'easy_sax'

class EasyBrokerSynchronizer
  XML_FILE = 'doc/sample-easybroker-data-feed_1_02.xml'
  BATCH_SIZE = 1000

  def self.synchronize
    properties_in_feed = Set.new

    File.open(XML_FILE) do |file|
      parser = EasySax.parser(file)
      
      ActiveRecord::Base.transaction do
        parser.parse_each('property') do |element|
          property_data = extract_property_data(element)
          properties_in_feed.add(property_data[:external_id])

          process_property(property_data)
        end

        deactivate_missing_properties(properties_in_feed)
      end
    end
  end

  private

  def self.extract_property_data(element)
    {
      external_id: element.attrs[:id],
      title: element.text_for('title'),
      description: element.text_for('description'),
      price: element.text_for('price').to_i,
      location_name: element.text_for('location'),
      feature_names: element.text_for('features')&.split(',') || []
    }
  end

  def self.process_property(property_data)
    location = Location.find_or_create_by!(name: property_data[:location_name])

    property = Property.find_or_initialize_by(external_id: property_data[:external_id])
    property.assign_attributes(
      title: property_data[:title],
      description: property_data[:description],
      price: property_data[:price],
      location: location,
      published: true
    )

    features = property_data[:feature_names].map do |feature_name|
      Feature.find_or_create_by!(name: feature_name.strip)
    end

    property.features = features

    property.save! if property.changed? || property.features.any?(&:changed?)
  end

  def self.deactivate_missing_properties(properties_in_feed)
    Property.where.not(external_id: properties_in_feed.to_a).find_in_batches(batch_size: BATCH_SIZE) do |batch|
      Property.where(id: batch.map(&:id)).update_all(published: false)
    end
  end
end
