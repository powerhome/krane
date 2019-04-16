# frozen_string_literal: true

module KubernetesDeploy
  class KubeclientBuilder
    class KubeConfig < Kubeclient::Config
      attr_accessor :filename
      def self.read(filename)
        parsed = YAML.safe_load(File.read(filename), [Date, Time])
        config = new(parsed, File.dirname(filename))
        config.filename = filename
        config
      end
    end
  end
end
