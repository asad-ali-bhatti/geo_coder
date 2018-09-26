require_relative 'application_spec_helper'

RSpec.describe Route do
  let(:valid_env) do
    {
        'PATH_INFO' => '/projects',
        'REQUEST_METHOD' => 'GET'
    }
  end
  let(:request) { Rack::Request.new(valid_env) }

  describe 'Attributes' do
    subject { Route.new(request) }
    it { should respond_to :path_info}
    it { should respond_to(:request) }
  end

  describe '#extract_path_info' do
    subject { Route.new(request) }
    before { subject.extract_path_info }

    it 'should set controller name from uri' do
      expect(subject.path_info[:controller_name]).to eql('ProjectsController')
    end

    it 'should set action name from uri' do
      expect(subject.path_info[:action_name]).to eql( 'index')
    end
  end

  describe '#controller' do
    subject { Route.new(request) }
    before { subject.controller }

    it 'should return controller Class object' do
      expect(subject.controller).to be_eql(ProjectsController)
    end
  end

  describe '#process_request' do
    let(:root_request) { Rack::Request.new({'PATH_INFO' => '/',
                                    'REQUEST_METHOD' => 'GET'}) }
    let(:index_request) { Rack::Request.new({'PATH_INFO' => '/projects',
                                             'REQUEST_METHOD' => 'GET'})  }
    let(:not_found_requet) { Rack::Request.new({'PATH_INFO' => '/burmoda_triangle',
                                                'REQUEST_METHOD' => 'GET'}) }

    context 'when request have root url' do
      it 'should return status 200 and view of ApplicationController#welcome' do
        response =  Route.new(root_request).process_request
        expect(response[0]).to be_eql(200)
        expect(response[2][0]).to be_eql('Welcome to geocoder')
      end
    end

    context 'when request is for index of resource' do
      it 'should return json type response' do
        response = Route.new(index_request).process_request
        expect(response[1]['Content-Type']).to be_eql('application/json')
        expect(response[0]).to be_eql(200)
      end
    end
  end
end