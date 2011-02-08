Raki::Plugin.register :cthn_menu do

  name 'CTHN Menü'
  description 'Linke Navigation'
  url 'http://www.cthn.de/'
  author 'Florian Schwab'
  version '0.1'

  execute do
    p = Page.find('page', 'Navigation')
    
    render :nothing => true unless p
    
    @page = context[:real_page] || Page.new(:namespace => Raki.frontpage[:namespace], :name => Raki.frontpage[:name])
    @areas = []
    
    items = []
    
    p.content.split("\n").each do |line|
      line = line.strip
      
      if line.blank?
        @areas << items
        items = []
      end
      
      next unless line =~ /^\*\s+\[([^\]]+)\]$/i
      
      tmp = $1.split '|'
      if tmp.length == 2
        link = tmp[0]
        title = tmp[1]
      else
        link = tmp[0]
        title = tmp[0]
      end
      
      if link =~ /^[a-z0-9]+:\/\//i
        items << {:url => link, :title => title}
      else
        items << {:page => page_for(link), :title => title}
      end
    end
    
    @areas << items unless items.empty?
  end

end
