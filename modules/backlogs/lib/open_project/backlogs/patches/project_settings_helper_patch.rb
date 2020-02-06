#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2020 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

require_dependency 'project_settings_helper'

module OpenProject::Backlogs::Patches::ProjectSettingsHelperPatch
  def self.included(base)
    base.module_eval do
      alias_method :project_settings_tabs_without_backlogs, :project_settings_tabs

      def project_settings_tabs
        project_settings_tabs_without_backlogs.tap do |settings|
          settings << {
            name: :backlogs,
            action: { controller: '/backlogs_settings', action: 'show' },
            label: :'backlogs.backlog_settings',
            if: ->(p) { p.module_enabled?('backlogs') }
          }
        end
      end
    end
  end
end

ProjectSettingsHelper.send(:include, OpenProject::Backlogs::Patches::ProjectSettingsHelperPatch)
