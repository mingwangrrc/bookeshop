<!DOCTYPE html>
<html>
  <head>
    <title><%= content_for(:title) || "Bookeshop" %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= yield :head %>

    <link rel="manifest" href="/manifest.json">
    <link rel="icon" href="/icon.png" type="image/png">
    <link rel="icon" href="/icon.svg" type="image/svg+xml">
    <link rel="apple-touch-icon" href="/icon.png">
    <%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
    <style>
      .form-group {
        margin-bottom: 15px;
      }
      .form-control {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }
      .btn {
        padding: 10px 15px;
        background-color: #111827;
        color: white;
        border: none;
        cursor: pointer;
      }
    </style>
  </head>

  <body>
    <main class="prose container mx-auto px-5">
    <%= yield %>
  </body>
</html>
<!DOCTYPE html>
<html>
  <head>
    <title><%= content_for(:title) || "Bookeshop" %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= yield :head %>

    <link rel="manifest" href="/manifest.json">
    <link rel="icon" href="/icon.png" type="image/png">
    <link rel="icon" href="/icon.svg" type="image/svg+xml">
    <link rel="apple-touch-icon" href="/icon.png">
    <%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
    <style>
      .form-group {
        margin-bottom: 15px;
      }
      .form-control {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }
      .btn {
        padding: 10px 15px;
        background-color: #111827;
        color: white;
        border: none;
        cursor: pointer;
      }
    </style>
  </head>

  <body>
    <main class="prose container mx-auto px-5">
    <%= yield %>
  </body>
</html>
<!DOCTYPE html>
<html>
  <head>
    <title><%= content_for(:title) || "Bookeshop" %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= yield :head %>

    <link rel="manifest" href="/manifest.json">
    <link rel="icon" href="/icon.png" type="image/png">
    <link rel="icon" href="/icon.svg" type="image/svg+xml">
    <link rel="apple-touch-icon" href="/icon.png">
    <%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
    <style>
      .form-group {
        margin-bottom: 15px;
      }
      .form-control {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }
      .btn {
        padding: 10px 15px;
        background-color: #111827;
        color: white;
        border: none;
        cursor: pointer;
      }
    </style>
  </head>

  <body>
    <main class="prose container mx-auto px-5">
    <%= yield %>
  </body>
</html>
class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    @q = Author.ransack(params[:q])
    @authors = @q.result(distinct: true)
  end

  def show
    @author = Author.find(params[:id])
  end
end
