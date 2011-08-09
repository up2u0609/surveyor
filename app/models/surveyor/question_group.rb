require "surveyor/models/question_group_methods"
class QuestionGroup < ActiveRecord::Base
  unloadable
  include Surveyor::Models::QuestionGroupMethods
  
end
