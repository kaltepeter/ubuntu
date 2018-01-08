require_relative 'spec_helper'

describe 'java' do
  it 'should have java installed' do
    expect(command('java -version').exit_status).to eq(0)
  end
end
