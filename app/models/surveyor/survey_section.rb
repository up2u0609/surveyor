module Surveyor
  class SurveySection < ActiveRecord::Base
    unloadable
    include Surveyor::Models::SurveySectionMethods
  end
end
