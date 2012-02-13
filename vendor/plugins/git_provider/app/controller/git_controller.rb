class GitController < ApplicationController
  # http://<host>/git.pull?namespace=<namespace>&token=<token>
  def pull
    if params[:token] and params[:namespace]
      options = Raki.config["providers"][params[:namespace].to_sym]
      if !options.nil? and options["provider"] == "git" and params[:token] == options["token"]
        Raki::Provider[params[:namespace]].git_pull
        # TODO: Update cache for updated files?
        render :text => "Git repository is up to date.", :status => 200
        return
      end
    end
    render :text => "Sorry, something went wrong here", :status => 500
  end
end

