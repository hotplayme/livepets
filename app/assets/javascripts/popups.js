// page init
function initPage(){
	initPopups();
}

// popups init
function initPopups() {
	lib.each(lib.queryElementsBySelector('li.popup-holder'), function(){
		new ContentPopup({
			holder: this
		});
	});
	lib.each(lib.queryElementsBySelector('.popup-hover'), function(){
		new ContentPopup({
			holder: this,
			mode: 'hover'
		});
	});
}

/*
 * Popups module
 */
function ContentPopup(opt) {
	this.options = lib.extend({
		holder: null,
		popup: '.popup',
		btnOpen: '.open',
		btnClose: '.close',
		openClass: 'popup-active',
		clickEvent: 'click',
		mode: 'click',
		hideOnClickLink: true,
		hideOnClickOutside: true,
		delay: 50
	}, opt);
	if(this.options.holder) {
		this.holder = this.options.holder;
		this.init();
	}
}
ContentPopup.prototype = {
	init: function() {
		this.findElements();
		this.attachEvents();
	},
	findElements: function() {
		this.popup = lib.queryElementsBySelector(this.options.popup, this.holder);
		this.btnOpen = lib.queryElementsBySelector(this.options.btnOpen, this.holder);
		this.btnClose = lib.queryElementsBySelector(this.options.btnClose, this.holder);
	},
	attachEvents: function() {
		// handle popup openers
		var self = this;
		this.clickMode = (self.options.mode === self.options.clickEvent);

		if(this.clickMode) {
			// handle click mode
			lib.each(this.btnOpen, function(index, btnOpen) {
				lib.event.add(btnOpen, self.options.clickEvent, function(e) {
					if(lib.hasClass(self.holder, self.options.openClass)) {
						if(self.options.hideOnClickLink) {
							self.hidePopup();
						}
					} else {
						self.showPopup();
					}
					e.preventDefault();
				});
			});

			// prepare outside click handler
			this.outsideClickHandler = lib.bind(this.outsideClickHandler, this);
		} else {
			// handle hover mode
			var timer, delayedFunc = function(func) {
				clearTimeout(timer);
				timer = setTimeout(function() {
					func.call(self);
				}, self.options.delay);
			};
			lib.each(this.btnOpen, function(index, btnOpen) {
				lib.event.add(btnOpen, 'mouseover', function() {
					delayedFunc(self.showPopup);
				});
				lib.event.add(btnOpen, 'mouseout', function() {
					delayedFunc(self.hidePopup);
				});
			});
			lib.each(this.popup, function(index, popup) {
				lib.event.add(popup, 'mouseover', function() {
					delayedFunc(self.showPopup);
				});
				lib.event.add(popup, 'mouseout', function() {
					delayedFunc(self.hidePopup);
				});
			});
		}

		// handle close buttons
		lib.each(this.btnClose, function(index, btnClose) {
			lib.event.add(btnClose, self.options.clickEvent, function(e) {
				self.hidePopup();
				e.preventDefault();
			});
		});
	},
	outsideClickHandler: function(e) {
		// hide popup if clicked outside
		var currentNode = (e.changedTouches ? e.changedTouches[0] : e).target;
		while(currentNode.parentNode) {
			if(currentNode === this.holder) {
				return;
			}
			currentNode = currentNode.parentNode;
		}
		this.hidePopup();
	},
	showPopup: function() {
		// reveal popup
		lib.addClass(this.holder, this.options.openClass);
		lib.each(this.popup, function(index, popup) {
			popup.style.display = 'block';
		});

		// outside click handler
		if(this.clickMode && this.options.hideOnClickOutside && !this.outsideHandlerActive) {
			this.outsideHandlerActive = true;
			lib.event.add(document, 'click', this.outsideClickHandler);
			lib.event.add(document, 'touchstart', this.outsideClickHandler);
		}
	},
	hidePopup: function() {
		// hide popup
		lib.removeClass(this.holder, this.options.openClass);
		lib.each(this.popup, function(index, popup) {
			popup.style.display = 'none';
		});

		// outside click handler
		if(this.clickMode && this.options.hideOnClickOutside && this.outsideHandlerActive) {
			this.outsideHandlerActive = false;
			lib.event.remove(document, 'click', this.outsideClickHandler);
			lib.event.remove(document, 'touchstart', this.outsideClickHandler);
		}
	}
};

/*
 * Utility module
 */
lib = {
	hasClass: function(el,cls) {
		return el && el.className ? el.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)')) : false;
	},
	addClass: function(el,cls) {
		if (el && !this.hasClass(el,cls)) el.className += " "+cls;
	},
	removeClass: function(el,cls) {
		if (el && this.hasClass(el,cls)) {el.className=el.className.replace(new RegExp('(\\s|^)'+cls+'(\\s|$)'),' ');}
	},
	extend: function(obj) {
		for(var i = 1; i < arguments.length; i++) {
			for(var p in arguments[i]) {
				if(arguments[i].hasOwnProperty(p)) {
					obj[p] = arguments[i][p];
				}
			}
		}
		return obj;
	},
	each: function(obj, callback) {
		var property, len;
		if(typeof obj.length === 'number') {
			for(property = 0, len = obj.length; property < len; property++) {
				if(callback.call(obj[property], property, obj[property]) === false) {
					break;
				}
			}
		} else {
			for(property in obj) {
				if(obj.hasOwnProperty(property)) {
					if(callback.call(obj[property], property, obj[property]) === false) {
						break;
					}
				}
			}
		}
	},
	event: (function() {
		var fixEvent = function(e) {
			e = e || window.event;
			if(e.isFixed) return e; else e.isFixed = true;
			if(!e.target) e.target = e.srcElement;
			e.preventDefault = e.preventDefault || function() {this.returnValue = false;};
			e.stopPropagation = e.stopPropagaton || function() {this.cancelBubble = true;};
			return e;
		};
		return {
			add: function(elem, event, handler) {
				if(!elem.events) {
					elem.events = {};
					elem.handle = function(e) {
						var ret, handlers = elem.events[e.type];
						e = fixEvent(e);
						for(var i = 0, len = handlers.length; i < len; i++) {
							if(handlers[i]) {
								ret = handlers[i].call(elem, e);
								if(ret === false) {
									e.preventDefault();
									e.stopPropagaton();
								}
							}
						}
					};
				}
				if(!elem.events[event]) {
					elem.events[event] = [];
					if(elem.addEventListener) elem.addEventListener(event, elem.handle, false);
					else if(elem.attachEvent) elem.attachEvent('on'+event, elem.handle);
				}
				elem.events[event].push(handler);
			},
			remove: function(elem, event, handler) {
				var handlers = elem.events[event];
				for(var i = handlers.length - 1; i >= 0; i--) {
					if(handlers[i] === handler) {
						handlers.splice(i,1);
					}
				}
				if(!handlers.length) {
					delete elem.events[event];
					if(elem.removeEventListener) elem.removeEventListener(event, elem.handle, false);
					else if(elem.detachEvent) elem.detachEvent('on'+event, elem.handle);
				}
			}
		};
	}()),
	queryElementsBySelector: function(selector, scope) {
		scope = scope || document;
		if(!selector) return [];
		if(selector === '>*') return scope.children;
		if(typeof document.querySelectorAll === 'function') {
			return scope.querySelectorAll(selector);
		}
		var selectors = selector.split(',');
		var resultList = [];
		for(var s = 0; s < selectors.length; s++) {
			var currentContext = [scope || document];
			var tokens = selectors[s].replace(/^\s+/,'').replace(/\s+$/,'').split(' ');
			for (var i = 0; i < tokens.length; i++) {
				token = tokens[i].replace(/^\s+/,'').replace(/\s+$/,'');
				if (token.indexOf('#') > -1) {
					var bits = token.split('#'), tagName = bits[0], id = bits[1];
					var element = document.getElementById(id);
					if (element && tagName && element.nodeName.toLowerCase() != tagName) {
						return [];
					}
					currentContext = element ? [element] : [];
					continue;
				}
				if (token.indexOf('.') > -1) {
					var bits = token.split('.'), tagName = bits[0] || '*', className = bits[1], found = [], foundCount = 0;
					for (var h = 0; h < currentContext.length; h++) {
						var elements;
						if (tagName == '*') {
							elements = currentContext[h].getElementsByTagName('*');
						} else {
							elements = currentContext[h].getElementsByTagName(tagName);
						}
						for (var j = 0; j < elements.length; j++) {
							found[foundCount++] = elements[j];
						}
					}
					currentContext = [];
					var currentContextIndex = 0;
					for (var k = 0; k < found.length; k++) {
						if (found[k].className && found[k].className.match(new RegExp('(\\s|^)'+className+'(\\s|$)'))) {
							currentContext[currentContextIndex++] = found[k];
						}
					}
					continue;
				}
				if (token.match(/^(\w*)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/)) {
					var tagName = RegExp.$1 || '*', attrName = RegExp.$2, attrOperator = RegExp.$3, attrValue = RegExp.$4;
					if(attrName.toLowerCase() == 'for' && this.browser.msie && this.browser.version < 8) {
						attrName = 'htmlFor';
					}
					var found = [], foundCount = 0;
					for (var h = 0; h < currentContext.length; h++) {
						var elements;
						if (tagName == '*') {
							elements = currentContext[h].getElementsByTagName('*');
						} else {
							elements = currentContext[h].getElementsByTagName(tagName);
						}
						for (var j = 0; elements[j]; j++) {
							found[foundCount++] = elements[j];
						}
					}
					currentContext = [];
					var currentContextIndex = 0, checkFunction;
					switch (attrOperator) {
						case '=': checkFunction = function(e) { return (e.getAttribute(attrName) == attrValue) }; break;
						case '~': checkFunction = function(e) { return (e.getAttribute(attrName).match(new RegExp('(\\s|^)'+attrValue+'(\\s|$)'))) }; break;
						case '|': checkFunction = function(e) { return (e.getAttribute(attrName).match(new RegExp('^'+attrValue+'-?'))) }; break;
						case '^': checkFunction = function(e) { return (e.getAttribute(attrName).indexOf(attrValue) == 0) }; break;
						case '$': checkFunction = function(e) { return (e.getAttribute(attrName).lastIndexOf(attrValue) == e.getAttribute(attrName).length - attrValue.length) }; break;
						case '*': checkFunction = function(e) { return (e.getAttribute(attrName).indexOf(attrValue) > -1) }; break;
						default : checkFunction = function(e) { return e.getAttribute(attrName) };
					}
					currentContext = [];
					var currentContextIndex = 0;
					for (var k = 0; k < found.length; k++) {
						if (checkFunction(found[k])) {
							currentContext[currentContextIndex++] = found[k];
						}
					}
					continue;
				}
				tagName = token;
				var found = [], foundCount = 0;
				for (var h = 0; h < currentContext.length; h++) {
					var elements = currentContext[h].getElementsByTagName(tagName);
					for (var j = 0; j < elements.length; j++) {
						found[foundCount++] = elements[j];
					}
				}
				currentContext = found;
			}
			resultList = [].concat(resultList,currentContext);
		}
		return resultList;
	},
	trim: function (str) {
		return str.replace(/^\s+/, '').replace(/\s+$/, '');
	},
	bind: function(f, scope, forceArgs){
		return function() {return f.apply(scope, forceArgs ? [forceArgs] : arguments);};
	}
};

if(window.addEventListener) window.addEventListener('load', initPage, false);
else if(window.attachEvent) window.attachEvent('onload', initPage);