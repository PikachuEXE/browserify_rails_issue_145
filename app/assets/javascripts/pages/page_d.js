//= require modules/index
//= require modules/module_d

var A = window.modules.moduleA;
var D = window.modules.moduleD;

var init = function () {
  console.log("pageD has "+ A.name + " and "+ D.name);
}

init();
