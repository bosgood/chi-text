require "spec_helper"
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end


describe DirectionsService do

  it 'returns directions' do
    VCR.use_cassette('synopsis', record: :new_episodes) do
      dir_serv = DirectionsService.new
      start_address = "11524 Fenwood Ct., Orland Park, IL 6047"
      end_address = "3316 N Lincoln, Chicago, IL 60657"
      expt_result = ["Head northeast on Fenwood Ct toward Creek Crossing Dr", "Take the 1st left onto Creek Crossing Dr", "Take the 1st right onto 143rd St", "Turn left onto US-45 N/South La Grange Road", "Merge onto I-55 N via the ramp to Chicago", "Take exit 292A for I-90 W/I-94 W toward W Ryan Expy/Wisconsin", "Merge onto I-90 W", "Take exit 48A for Armitage Ave toward 2000 N", "Turn right onto W Armitage Ave", "Take the 2nd left onto N Ashland Ave", "Slight left onto N Lincoln AveDestination will be on the left"]
      dir_serv.get_step_by_step_directions( start_address, end_address).should eq(expt_result)
    end
  end
end
    
