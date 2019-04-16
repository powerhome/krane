# frozen_string_literal: true

module KubernetesDeploy
  class KubeclientBuilder
    class KubeConfig < Kubeclient::Config
      def self.read(filename)
        parsed = YAML.safe_load(File.read(filename), [Date, Time])
        new(parsed, File.dirname(filename))
      end
    end
  end
end
