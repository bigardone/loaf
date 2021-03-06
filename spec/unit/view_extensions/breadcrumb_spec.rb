# encoding: utf-8

require 'spec_helper'

RSpec.describe Loaf::ViewExtensions, '.breadcrumb' do

  it { expect(DummyView.new).to respond_to(:add_breadcrumb) }

  it 'creates crumb instance' do
    instance = DummyView.new
    name = 'Home'
    url  = :home_path
    allow(Loaf::Crumb).to receive(:new).with(name, url, {})
    instance.breadcrumb name, url
    expect(Loaf::Crumb).to have_received(:new).with(name, url, {})
  end

  it 'adds crumb to breadcrumbs storage' do
    instance = DummyView.new
    expect {
      instance.breadcrumb 'Home', :home_path
    }.to change { instance._breadcrumbs.size }.by(1)
  end
end
