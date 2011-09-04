require 'rails/generators'
require 'rails/generators/migration'
class SurveyorGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      if current_migration_number(dirname).to_s == "0"
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        current_migration_number(dirname) + 1
      end
    else
      current_migration_number(dirname) + 1
    end
  end
  
  def copy_migrations
    [ "create_surveys", "create_survey_sections", "create_questions", "create_question_groups", "create_answers", 
      "create_response_sets", "create_responses", 
      "create_dependencies", "create_dependency_conditions", 
      "create_validations", "create_validation_conditions", 
      "add_display_order_to_surveys", "add_correct_answer_id_to_questions",
      "add_index_to_response_sets", "add_index_to_surveys", 
      "add_unique_indicies", "add_section_id_to_responses",
      "add_default_value_to_answers", "add_api_ids",
      "add_display_type_to_answers"].each do | m |
        migration_template "migrate/#{m}.rb" , "db/migrate/#{m}.rb"
    end
  end
  
  def copy_locales
    empty_directory "config/locales"
    Dir.glob(File.join(File.dirname(__FILE__), "templates", "locales", "*.yml")).map{|path| File.basename(path)}.each do |filename|
      copy_file "locales/#{filename}", "config/locales/#{filename}"
    end
  end
end
