require 'front_matter_parser'

desc "Import Articles"
task :import_articles => [:environment] do

  articles = Dir.glob("/../**/*.md")

  articles.each do |article|
    parsed = FrontMatterParser::Parser.parse_file(article)
    
    article = Article.new

    article.title = parsed.front_matter["title"]
    article.slug = parsed.front_matter["slug"]
    article.content = parsed.content
    article.published_at = parsed.front_matter["date"]

    article.save
  end

end