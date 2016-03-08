# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.livepets.ru"

SitemapGenerator::Sitemap.create do

  Article.find_each do |article|
    add article_path(article.randid), lastmod: article.updated_at
  end

  Blog.find_each do |blog|
    add blog_path(blog), lastmod: blog.updated_at
  end

end
