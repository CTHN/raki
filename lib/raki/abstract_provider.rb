# Raki - extensible rails-based wiki
# Copyright (C) 2010 Florian Schwab
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

module Raki
  class AbstractProvider
    def page_exists?(name, revision=nil)
    end

    def page_contents(name, revision=nil)
    end

    def page_revisions(name)
    end

    def save_page(name, contents, user, message)
    end

    private

    class Revision
      attr_reader :id
      attr_reader :user
      attr_reader :date
      attr_reader :message

      def initialize(id, user, date, message)
        @id = id
        @user = user
        @date = date
        @message = message
      end
    end
  end
end