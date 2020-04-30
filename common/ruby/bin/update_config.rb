#!/usr/bin/env ruby
require_relative('../lib/symbol_utilities')

unless ARGV.size == 1
  STDERR << "Usage #{$0} NODE_TYPE\n"
  exit 1
end

node_type = ARGV[0]
target_config_dir = "/usr/share/base/#{node_type}/userconfig/resources"
unless ::Dir.exists?(target_config_dir)
  STDERR << "Target directory '#{target_config_dir}' does not exist"
end

SymbolUtilities::GenerateCertsAndKeys.generate(node_type, target_config_dir)
SymbolUtilities::RunTimeVars::SetVar.run
SymbolUtilities::PeersConfig::RemoteStore.new(target_config_dir).install

