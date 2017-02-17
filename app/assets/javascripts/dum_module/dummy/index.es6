import $ from 'jquery';

const event_emitter = {
  room:{},
  on: ()=>{
  	console.log("hello");
  },
  off: ()=>{
  	console.log("world");
  }
}

export default event_emitter;
