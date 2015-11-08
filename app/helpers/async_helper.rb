module AsyncHelper

  def javascript_async(*args)
    content_tag :script, type: "text/javascript" do
      "(function() {
      var script = document.createElement('script');
      script.type = 'text/javascript';
      script.async = true;
      script.src = '#{j javascript_path(*args)}';
      var other = document.getElementsByTagName('script')[0];
      other.parentNode.insertBefore(script, other);
      })();".html_safe
    end
  end

end
