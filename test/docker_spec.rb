require_relative 'spec_helper'

describe 'docker' do

  # docker_string = command('which docker').stdout
  it 'should have docker installed and on path' do
    # expect(docker_string).to include('/usr/bin/docker')
    expect(command('which docker').exit_status).to eq(0)
  end

  it 'should run docker hello-world' do
    expect(command('docker run hello-world').exit_status).to eq(0)
  end

  it 'should have docker group' do
    expect(command('groups vagrant').stdout).to include('docker')
  end

  it 'should have vagrant user in docker group' do
    expect(user 'vagrant').to belong_to_group 'docker'
  end

  it 'should have docker.service configured' do
    has_docker_systemctl = command('sudo systemctl status docker').exit_status
    expect(has_docker_systemctl).to eq(0)
  end
end
