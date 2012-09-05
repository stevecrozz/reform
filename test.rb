require 'rubygems'
require 'bundler'
require 'test/unit'
require 'logger'
Bundler.require(:default, :test)

require 'reform/base'
require 'reform/select_options'
require 'reform/field/base'
require 'reform/field/text'
require 'reform/field/select'
require 'reform/field/text_area'
require 'reform/field/hidden'
require 'reform/renderer/base'
require 'reform/renderer/ol_renderer'

require 'test/fixture'
require 'test/declare'
require 'test/render'
require 'test/instantiate'
require 'test/select_options'
require 'test/field/text'
require 'test/field/select'
require 'test/field/hidden'

Bundler.require(:active_record)
require 'active_record'
require 'reform/model/active_record'
require 'test/model/active_record'
