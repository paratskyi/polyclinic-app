module Profiles
  class LoadDoctorProfiles < Base
    DOCTOR_FILTERS = [:category_id].freeze

    private

    def load_collection
      @collection = Profile.doctors.preload(user: [:category])
    end

    def filter_collection!
      @collection = @collection
                    .joins("LEFT JOIN doctors ON profiles.user_id = doctors.id")
                    .where(doctors: doctor_filter_params)
    end

    def doctor_filter_params
      DOCTOR_FILTERS.index_with do |doctor_filter|
        @filters[doctor_filter]
      end
    end
  end
end
