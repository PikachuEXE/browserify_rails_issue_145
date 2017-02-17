var moduleA = require("./module_a").default;
var moduleB = require("./module_b").default;
var moduleC = require("./module_c").default;


function deepExtend (dst, src){
  for(var prop in src){
    if(dst.hasOwnProperty(prop)){
      dst[prop] = deepExtend(dst[prop], src[prop]);
    }else{
      dst[prop] = src[prop];
    }
  }
  return dst;
}

var es6_module = {
  moduleA: moduleA,
  moduleB: moduleB,
  moduleC: moduleC,
};

window.modules = window.modules || {};
deepExtend(window.modules, es6_module);
