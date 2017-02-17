import C from "modules/module_c";
import $ from "jquery";
const old_D = window.modules.moduleD;

// can have old module by global
const init = ()=>{
  console.log(`pageB has ${C.name} and ${old_D.name}`);
}

export default {init};
