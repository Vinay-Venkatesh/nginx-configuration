require 'spec_helper'
describe 'neo4j' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "config" do

        context 'with defaults for all parameters' do
          it { should contain_concat('/etc/neo4j/neo4j.conf') }          
          it { should contain_concat__fragment('neo4j config general') }
          it { should contain_concat__fragment('neo4j config connectors') }
          it { should contain_concat__fragment('neo4j config backups') }
          it { should contain_concat__fragment('neo4j config authentication and authorization') }
          it { should contain_concat__fragment('neo4j config logging') }
          it { should contain_concat__fragment('neo4j config query management') }
          it { should_not contain_concat__fragment('neo4j config HA cluster') }
          it { should_not contain_concat__fragment('neo4j config causal cluster') }                                      end

        context 'with dbms_mode in [\'ARBITER\', \'HA\']' do
          context 'with dbms_mode set to ARBITER' do
            let(:params) {
              {
                :dbms_mode => 'ARBITER',
                :version   => '3.0.8'               
              }
            }
            it { should contain_concat__fragment('neo4j config HA cluster') }
          end
          context 'with dbms_mode set to HA' do
            let(:params) {
              {
                :dbms_mode => 'HA',
                :version   => '3.0.8'               
              }
            }
            it { should contain_concat__fragment('neo4j config HA cluster') }
          end          
         end

         context 'with dbms_mode in [\'CORE\', \'READ_REPLICA\']' do
           context 'with dbms_mode set to CORE' do
             let(:params) {
               {
                 :dbms_mode => 'CORE',
                 :version   => '3.1.1'
               }
             }
             it { should contain_concat__fragment('neo4j config causal cluster') }
           end
           context 'with dbms_mode set to READ_REPLICA' do
             let(:params) {
               {
                 :dbms_mode => 'READ_REPLICA',
                 :version   => '3.1.1'
               }
             }
             it { should contain_concat__fragment('neo4j config causal cluster') }
           end           
         end        

         context 'with install_method set to archive and version to 3.0.8' do
          let(:params) {
            {
                :install_method => 'archive',
                :install_prefix => '/usr/share',
                :version        => '3.0.8'
            }
          }
          it { should contain_concat('/usr/share/neo4j-community-3.0.8/conf/neo4j.conf') }
         end

         context 'with install_method set to archive and version to 3.1.1' do
           let(:params) {
            {
                :install_method => 'archive',
                :install_prefix => '/usr/share',
                :version        => '3.1.1'
            }
          }
          it { should contain_concat('/usr/share/neo4j-community-3.1.1/conf/neo4j.conf') }
          it { should contain_concat__fragment('neo4j config metrics logging') }
         end
     end
    end
  end
end
