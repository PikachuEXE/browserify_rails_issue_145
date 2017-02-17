// require module_d here as page_b use it
// in fact the excution order of application already require first
//= require modules/module_d

var page_a = require("./page_a").default;
var page_b = require("./page_b").default;

page_a.init();
page_b.init();
