require 'spec_helper'

describe 'neo4j', :type => :class do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to compile.with_all_deps }
        it { should contain_class('neo4j') }
        it { should contain_anchor('neo4j::begin').that_comes_before('Class[neo4j::Install]') }
        it { should contain_class('neo4j::install').that_comes_before('Class[neo4j::Config]') }
        it { should contain_class('neo4j::config').that_notifies('Class[neo4j::Service]') }
        it { should contain_class('neo4j::service').that_comes_before('Anchor[neo4j::end]') }
        it { should contain_anchor('neo4j::end') }

        case facts[:osfamily]
        when 'Debian'
        case facts[:operatingsystemrelease]
        when /(^7.*|^14\.04.*)/
          it { should contain_service('neo4j').with({
            'ensure'   => 'running',
            'enable'   => true,
            'name'     => 'neo4j',
            'provider' => 'debian',
            })
          }
        else
          it { should contain_service('neo4j').with({
            'ensure'   => 'running',
            'enable'   => true,
            'name'     => 'neo4j',
            'provider' => 'systemd',
            })
          }
        end
        when 'RedHat'
        case facts[:operatingsystemrelease]
        when /^6.*/
          it { should contain_service('neo4j').with({
            'ensure'   => 'running',
            'enable'   => true,
            'name'     => 'neo4j',
            'provider' => 'redhat',
            })
          }
        else
          it { should contain_service('neo4j').with({
            'ensure'   => 'running',
            'enable'   => true,
            'name'     => 'neo4j',
            'provider' => 'systemd',
            })
          }
        end
        end

        it { should_not contain_file('/etc/init.d/neo4j') }
        it { should_not contain_systemd__unit('neo4j.service') }
      end

      context 'with install method set to archive' do
        let(:params) {
          {
            :install_method => 'archive',
            :install_prefix => '/usr/share',
            :version        => '3.1.1'
          }
        }

        context 'with service_provider set to magic' do
          let(:params) {
            {
              :install_method   => 'archive',
              :install_prefix   => '/usr/share',
              :service_provider => 'magic',
              :version          => '3.1.1',
            }
          }
          it { should raise_error(/\"magic\" does not match \"debian|init|redhat|systemd\"/)}
        end

        case facts[:osfamily]
        when 'Debian'
          case facts[:operatingsystemrelease]
          when /(^7.*|^14\.04.*)/
            it { should contain_file('/etc/init.d/neo4j') }
            it { should_not contain_systemd__unit('neo4j.service') }

            context 'with user and group set to test' do
              let(:params) {
                {
                  :group          => 'test',
                  :install_method => 'archive',
                  :install_prefix => '/usr/share',
                  :version        => '3.1.1',
                  :user           => 'test',
                }
              }
              it { should contain_file('/etc/init.d/neo4j').with({
                'group' => 'test',
                'owner' => 'test',
                })
              }
            end

            context 'with service_name set to test' do
              let(:params) {
                {
                  :group          => 'test',
                  :install_method => 'archive',
                  :install_prefix => '/usr/share',
                  :version        => '3.1.1',
                  :user           => 'test',
                  :service_name   => 'test',
                }
              }
              it { should contain_file('/etc/init.d/test') }
            end
          else
            it { should_not contain_file('/etc/init.d/neo4j') }
            it { should contain_systemd__unit_file('neo4j.service') }
          end
        when 'RedHat'
          case facts[:operatingsystemrelease]
          when /^6.*/
            it { should contain_file('/etc/init.d/neo4j') }
            it { should_not contain_systemd__unit('neo4j.service') }

            context 'with user and group set to test' do
              let(:params) {
                {
                  :group          => 'test',
                  :install_method => 'archive',
                  :install_prefix => '/usr/share',
                  :version        => '3.1.1',
                  :user           => 'test',
                }
              }
              it { should contain_file('/etc/init.d/neo4j').with({
                  'group' => 'test',
                  'owner' => 'test',
                })
              }
            end

            context 'with service_name set to test' do
              let(:params) {
                {
                  :group          => 'test',
                  :install_method => 'archive',
                  :install_prefix => '/usr/share',
                  :version        => '3.1.1',
                  :user           => 'test',
                  :service_name   => 'test',
                }
              }
              it { should contain_file('/etc/init.d/test') }
            end
          else
            it { should_not contain_file('/etc/init.d/neo4j') }
            it { should contain_systemd__unit_file('neo4j.service') }
          end
        end
      end
    end
  end
end
