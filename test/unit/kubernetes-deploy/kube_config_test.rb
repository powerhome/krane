# frozen_string_literal: true
require 'test_helper'

class KubeConfigTest < KubernetesDeploy::TestCase
  def setup
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.allow_net_connect!
  end

  def test_username_password_auth_works
    config = KubernetesDeploy::KubeclientBuilder::KubeConfig.new(kubeconfig, "")

    context = config.context("minikube")

    assert_equal('test', context.auth_options[:password])
    assert_equal('admin', context.auth_options[:username])
  end

  def kubeconfig
    {
      'apiVersion' => 'v1',
      'clusters' => [
        { 'cluster' => { 'server' => 'https://192.168.64.3:8443' }, 'name' => 'test' },
      ],
      'contexts' => [
        {
          'context' => {
            'cluster' => 'test', 'user' => 'minikube'
          },
          'name' => 'minikube',
        },
      ],
      'users' => [
        {
          'name' => 'minikube',
          'user' => {
            'password' => 'test',
            'username' => 'admin',
          },
        },
      ],
    }.stringify_keys
  end
end
