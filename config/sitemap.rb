require 'rubygems'
require 'sitemap_generator'

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://fun.shooloo.org"

# To disable all non-essential output
SitemapGenerator.verbose = false

SitemapGenerator::Sitemap.create do
  add about_path, :priority => 0.9, :changefreq => 'monthly'
  add posts_path, :priority => 0.8, :changefreq => 'daily'
  add lessons_path, :priority => 0.8, :changefreq => 'daily'
  add standards_path, :priority => 0.8, :changefreq => 'monthly'
  add grade_k_path, :priority => 0.8, :changefreq => 'daily'
  add grade_1_path, :priority => 0.8, :changefreq => 'daily'
  add grade_2_path, :priority => 0.8, :changefreq => 'daily'
  add grade_3_path, :priority => 0.8, :changefreq => 'daily'
  add grade_4_path, :priority => 0.8, :changefreq => 'daily'
  add grade_5_path, :priority => 0.8, :changefreq => 'daily'
  add grade_6_path, :priority => 0.8, :changefreq => 'daily'
  add grade_7_path, :priority => 0.8, :changefreq => 'daily'
  add grade_8_path, :priority => 0.8, :changefreq => 'daily'
  add grade_8_path, :priority => 0.8, :changefreq => 'daily'
  add hs_algebra_path, :priority => 0.8, :changefreq => 'daily'
  add hs_modeling_path, :priority => 0.8, :changefreq => 'daily'
  add hs_geometry_path, :priority => 0.8, :changefreq => 'daily'
  add hs_stats_path, :priority => 0.8, :changefreq => 'daily'
  add hs_functions_path, :priority => 0.8, :changefreq => 'daily'
  add signup_path, :priority => 0.7, :changefreq => 'never'  
  add contact_path, :priority => 0.6, :changefreq => 'monthly'
  add team_path, :priority => 0.5, :changefreq => 'monthly'
  add advisors_path, :priority => 0.5, :changefreq => 'monthly'
  add rules_path, :priority => 0.4, :changefreq => 'yearly'
  add terms_path, :priority => 0.4, :changefreq => 'yearly'
  add privacy_path, :priority => 0.4, :changefreq => 'yearly'
  add signin_path, :priority => 0.3, :changefreq => 'never'
  add videos_path, :priority => 0.7, :changefreq => 'never'
  add contest_path, :priority =>0.9, :changefreq => 'weekly'  
  add practice_path, :priority =>0.8, :changefreq => 'monthly' 
  
  Post.find_each do |post|
    add new_post_comment_path(post), :lastmod => post.updated_at,
    :priority => 0.8, :changefreq => 'daily'
  end

  Video.find_each do |video|
    add video_path(video), :lastmod => video.updated_at,
    :priority => 0.8, :changefreq => 'daily',
    :video => {
      :thumbnail_loc => "https://fun.shooloo.org#{video.thumbnail.url}" ,
      :title => "#{video.title}",
      :description => "#{video.description}",
      :content_loc => "https://fun.shooloo.org#{video.video_mp4}",
      :content_loc => "https://fun.shooloo.org#{video.video_ogv}",
      :content_loc => "https://fun.shooloo.org#{video.video_webm}",
      :tags => %w["#{video.tags}.split(',')"],
      :category => "#{video.category.name}",
      :duraton => "#{video.duration}",
      :allow_embed => 'yes',
      :autoplay => 'yes',
      :family_friendly => 'yes',
      :gallery_loc => "https://fun.shooloo.org#{videos_path}",
      :gallery_title => 'Shooloo Video Tutorials'
    }
  end
end

 

