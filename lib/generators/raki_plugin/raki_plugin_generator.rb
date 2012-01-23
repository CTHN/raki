# Raki - extensible rails-based wiki
# Copyright (C) 2010 Florian Schwab & Martin Sigloch
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class RakiPluginGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  attr_reader :plugin_name, :plugin_class, :plugin_pretty_name

  def generate_layout
    plugin_path = "vendor/plugins/raki_#{file_name.underscore}"

    @plugin_name = file_name.underscore
    @plugin_class = file_name.classify
    @plugin_pretty_name = file_name.underscore.titleize

    empty_directory "#{plugin_path}"
    empty_directory "#{plugin_path}/app"
    empty_directory "#{plugin_path}/assets"
    empty_directory "#{plugin_path}/assets/images"
    empty_directory "#{plugin_path}/assets/stylesheets"
    empty_directory "#{plugin_path}/config/locales"
    empty_directory "#{plugin_path}/templates"
    empty_directory "#{plugin_path}/templates/#{@plugin_name}"
    empty_directory "#{plugin_path}/test"

    template 'README.rdoc.erb', "#{plugin_path}/README.rdoc"
    template 'init.rb.erb', "#{plugin_path}/init.rb"
    template 'en.yml.erb', "#{plugin_path}/config/locales/en.yml"
    template 'plugin_test.rb.erb', "#{plugin_path}/test/#{@plugin_name}_test.rb"
    template 'template.erb', "#{plugin_path}/templates/#{@plugin_name}/#{@plugin_name}.erb"
    template 'gitkeep', "#{plugin_path}/app/.gitkeep"
  end
end

