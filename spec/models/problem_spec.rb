require 'rails_helper'

describe Problem, type: :model do
  describe '.latest' do
    let(:problems) { create_list(:problem, 5, created_at: 1.day.ago) }

    before { create_list(:problem, 3, created_at: 2.days.ago) }

    it "returns the last 5 problems sorted by \'created_at\'" do
      expect(described_class.latest).to match_array(problems)
    end
  end
end
