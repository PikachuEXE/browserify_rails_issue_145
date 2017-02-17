import B from "modules/module_b";
import A from "modules/module_a";
import $ from "jquery";

//cool with es6 import es6
const init = () => {
  console.log(`pageA has ${B.name} and ${A.name}`);
}

export default { init };

