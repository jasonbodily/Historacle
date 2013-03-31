










//(function(window) {
//
//   function create(element_id) {
//      //if expression starts with # then return the corresponding element (substring removes first char)
//      if (/^#/.test(element_id)) return document.getElementById(element_id.substring(1));
//      element_id = qualify(element_id);
//      return element_id.space == null
//         ? document.createElement(element_id.local)
//         : document.createElementNS(element_id.space, element_id.local);
//   }
//
//   function qualify(element_id) {
//      var i = element_id.indexOf(":");
//      return {
//         space: createJElement.prefix[element_id.substring(0, i)],
//         local: element_id.substring(i + 1)
//      };
//   }
//
//   function historacle(elemnt) {
//      this.element = elemnt;
//   }




//   function renderEvent(event) {
//
//   }
//
//   var historacle = {
//
//      chronicles: {},
//
//      addChronicle: function(chronicle) {
//         chronicle.active = true;
//         return this.chronicles[chronicle.id] = chronicle;
//      },
//
//      activateChronicle: function(id) {
//         return this.chronicles[id].active = true;
//      },
//
//      deactivateChronicle: function(id) {
//         return this.chronicles[id].active = false;
//      }
//   }
//



////      remove: function(c) {
//         this.element.removeChild(getJElement(c));
//         return this;
//      },
//
//      parent: function() {
//         return createJElement(this.element.parentNode);
//      },
//
//      child: function(i) {
//         var children = this.element.childNodes;
//         return createJElement(children[i < 0 ? children.length - i - 1 : i]);
//      },
//
//      previous: function() {
//         return createJElement(this.element.previousSibling);
//      },
//
//      next: function() {
//         return createJElement(this.element.nextSibling);
//      },
//
//      attr: function(n, v) {
//         var e = this.element;
//         n = qualify(n);
//         if (arguments.length == 1) {
//            return n.space == null
//               ? e.getAttribute(n.local)
//               : e.getAttributeNS(n.space, n.local);
//         }
//         if (n.space == null) {
//            if (v == null) e.removeAttribute(n.local);
//            else e.setAttribute(n.local, v);
//         } else {
//            if (v == null) e.removeAttributeNS(n.space, n.local);
//            else e.setAttributeNS(n.space, n.local, v);
//         }
//         return this;
//      },
//
//      style: function(n, v, p) {
//         var style = this.element.style;
//         if (arguments.length == 1) return style.getPropertyValue(n);
//         if (v == null) style.removeProperty(n);
//         else style.setProperty(n, v, arguments.length == 3 ? p : null);
//         return this;
//      },
//
//      on: function(t, l, c) {
//         this.element.addEventListener(t, l, arguments.length == 3 ? c : false);
//         return this;
//      },
//
//      off: function(t, l, c) {
//         this.element.removeEventListener(t, l, arguments.length == 3 ? c : false);
//         return this;
//      },
//
//      text: function(v) {
//         var t = this.element.firstChild;
//         if (!arguments.length) return t && t.nodeValue;
//         if (t) t.nodeValue = v;
//         else if (v != null) t = this.element.appendChild(document.createTextNode(v));
//         return this;
//      }
//   }
//
//   function createJElement(jelement) {
//      return jelement == null || jelement.element ? jelement : new jElement(typeof jelement == "string" ? create(jelement) : jelement);
//   }
//
//   function getJElement(je) {
//      return je && je.element || je;
//   }
//
//   createJElement.prefix = {
//      svg: "http://www.w3.org/2000/svg"
//   };
//
//   createJElement.version = "1.1.0";

//   window.historacle = historacle;
//   window.getJElement = getJElement;
//})(this);
