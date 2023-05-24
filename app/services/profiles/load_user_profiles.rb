module Profiles
  class LoadUserProfiles < Base
    private

    def load_collection
      @collection = Profile.doctors.preload(:user)
    end
  end
end
