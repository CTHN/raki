Raki::Plugin.register :cthn_menu do

  name 'Cthn Menu plugin'
  description 'Simple plugin to generate the menu dynamically.'
  url 'http://cthn.de/'
  author 'Aaron Mueller'
  version '0.0.1'

  execute do
    body # Body of plugin
    params # Parameters given to plugin
    context # Execution context

    # FIXME: Really dirty. Is there a way to access the parser directly?
    @menus = body.split(/\r?\n\r?\n/).map do |block|
      block.split(/\r?\n/).map do |line|
        link = line.match(/\[([^|]*)\|([^\]]*)/)
        [link[1], link[2]] if link
      end.delete_if {|l| l.nil?}
    end
    render :cthn_menu
  end
end
