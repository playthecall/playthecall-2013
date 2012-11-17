if (typeof Object.create !== "function") {
  Object.create = function (a) {
    function b() {}
    b.prototype = a;
    return new b
  }
}(function (a, b, c, d) {
  a.fn.doGlobe = function (b) {
    if (Detector.webgl) {
      var c = Object.create(e);
      c.init(b, this);
      return this
    } else {
      var d = a(this);
      return false
    }
  };
  a.fn.doGlobe.options = {
    globeRadius: 200,
    globeShine: 30,
    globeTexture: "textures/earthmap10k_comp.jpg",
    globeMinScale: .3,
    globeMaxScale: 4,
    globeSegments: 50,
    ambientIntensity: 4.6,
    ambientColor: 5592452,
    ambientPosX: 5e3,
    ambientPosY: -824,
    ambientPosZ: 495,
    headLampIntensity: 1.2,
    headLampColor: 16777215,
    headLampPosX: -1e9,
    headLampPosY: 1e9,
    headLampPosZ: 1e9,
    hotSpotRadius: 10,
    hotspotOffset: 0,
    hotSpotTexture: "textures/hotspotTexture.png",
    hotspotDynamicScale: true,
    backPlateTexture: '',
    backPlateMargin: 50,
    debugMode: false,
    popWidth: 50,
    popHeight: 20,
    camX: 0,
    camY: 0,
    camZ: 1500,
    contentClass: ".poi",
    cameraTargetX: 0,
    cameraTargetY: 0,
    cameraTargetZ: 0
  };
  var e = {
    init: function (b, c) {
      var d = this;
      d.elem = c;
      d.$elem = a(c);
      d.targetRotation_x = 0;
      d.targetRotation_y = 0;
      d.hotspotsArr = [];
      d.hotspotDivsArr = [];
      d.options = a.extend({}, a.fn.doGlobe.options, b);
      d.windowDimensionX = d.$elem.innerWidth();
      d.windowDimensionY = d.$elem.innerHeight();
      a.colorbox.settings.width = d.options.popboxWidth;
      a.colorbox.settings.height = d.options.popboxHeight;
      d.refreshGlobe();
      d.animate()
    },
    deleteOldAnimationHandler: function () {
      try {
        cancelAnimationFrame(this.animationHandler);
        console.log("clearhandler")
      } catch (a) {
        console.log("noHandler: " + a)
      }
    },
    refreshGlobe: function () {
      var a = this;
      a.setup3D();
      a.generateContent();
      a.setupListeners();
      if (a.options.debugMode === true) {
        console.log("settingUpDebug");
        a.setupDebug()
      }
    },
    setup3D: function () {
      var a = this;
      a.projector = new THREE.Projector;
      a.globeContainer = new THREE.Object3D;
      a.globeContainer.name = "globeContainer";
      a.globeContainerParent = new THREE.Object3D;
      a.globeContainerParent.name = "globeContainerParent";
      a.backPlateContainer = new THREE.Object3D;
      a.backPlateContainer.name = "backPlateContainer";
      a.scaleContainer = new THREE.Object3D;
      a.scaleContainer.name = "scaleContainer";
      a.scene = new THREE.Scene;
      a.camera = new THREE.OrthographicCamera(a.windowDimensionX / -2, a.windowDimensionX / 2, a.windowDimensionY / 2, a.windowDimensionY / -2, 1, 2e3);
      a.camera.position.x = a.options.camX;
      a.camera.position.y = a.options.camY;
      a.camera.position.z = a.options.camZ;
      // console.log(a.camera);
      a.camera.lookAt(new THREE.Vector3(a.options.cameraTargetX, a.options.cameraTargetY, a.options.cameraTargetZ));
      a.scene.add(a.camera);
      a.ambient = new THREE.PointLight(a.options.ambientColor, a.options.ambientIntensity);
      a.ambient.position.set(a.options.ambientPosX, a.options.ambientPosY, a.options.ambientPosZ);
      a.scaleContainer.add(a.ambient);
      a.headLamp = new THREE.PointLight(a.options.headLampColor, a.options.headLampIntensity);
      a.headLamp.position.set(a.options.headLampPosX, a.options.headLampPosY, a.options.headLampPosZ);
      a.headLamp.lookAt(a.globeContainer.position);
      a.scaleContainer.add(a.headLamp);
      a.backPlateTexture = THREE.ImageUtils.loadTexture(a.options.backPlateTexture);
      a.globeTexture = THREE.ImageUtils.loadTexture(a.options.globeTexture);
      a.hotspotTexture = THREE.ImageUtils.loadTexture(a.options.hotSpotTexture);
      var b = new THREE.MeshPhongMaterial({
        map: a.globeTexture,
        ambient: 5592405,
        color: 16777215,
        specular: 5592405,
        shininess: a.options.globeShine
      });
      a.hotSpotMaterial = new THREE.MeshPhongMaterial({
        alphaTest: .5,
        transparent: true,
        map: a.hotspotTexture,
        color: "0xffffff"
      });
      a.backPlateMaterial = new THREE.MeshBasicMaterial({
        map: a.backPlateTexture,
        color: "0xffffff"
      });
      a.globeGeo = new THREE.Mesh(new THREE.SphereGeometry(a.options.globeRadius, a.options.globeSegments, a.options.globeSegments), b);
      a.globeGeo.position.x = 0;
      a.globeGeo.position.y = 0;
      a.globeGeo.position.z = 0;
      a.globeGeo.name = "theGlobe";
      a.globeContainer.add(a.globeGeo);
      var c = 2 * a.options.globeRadius + a.options.backPlateMargin;
      a.backPlate = new THREE.Mesh(new THREE.PlaneGeometry(c, c), a.backPlateMaterial);
      a.backPlateContainer.add(a.backPlate);
      a.renderer = new THREE.WebGLRenderer({
        antialias: true,
        alpha: true
      });
      a.renderer.clear();
      a.renderer.setSize(a.windowDimensionX, a.windowDimensionY);
      a.renderer.autoClear = true;
      a.elem.append(a.renderer.domElement);
      a.scene.add(a.scaleContainer);
      a.scaleContainer.add(a.backPlateContainer);
      a.scaleContainer.add(a.globeContainerParent);
      a.globeContainerParent.add(a.globeContainer)
    },
    setupDebug: function () {
      var a = this;
      console.log("setupDebug");
      a.setUpStats()
    },
    setUpStats: function () {
      var a = this;
      a.stats = new Stats;
      a.stats.domElement.style.position = "absolute";
      a.stats.domElement.style.top = "0";
      a.elem.append(a.stats.domElement)
    },
    generateContent: function () {
      var b = this;
      b.hotspotDivsArr = a(b.options.contentClass);
      b.hotspotDivsArr.each(function (c) {
        var d = a(this).data("long");
        var e = a(this).data("lat");
        var f = b.translateGeoCoords(e, d, b.options.globeRadius + b.options.hotspotOffset);
        var g;
        g = new THREE.Mesh(new THREE.PlaneGeometry(2 * b.options.hotSpotRadius, 2 * b.options.hotSpotRadius), b.hotSpotMaterial);
        g.doubleSided = false;
        g.scale.set(-1, 1, -1);
        g.position.x = f.x;
        g.position.y = f.y;
        g.position.z = f.z;
        g.lookAt(b.globeContainer.position);
        g.name = c;
        b.hotspotsArr.push(g);
        b.globeContainer.add(g)
      })
    },
    translateGeoCoords: function (a, b, c) {
      var d = c * Math.cos(a * Math.PI / 180) * Math.cos(b * Math.PI / 180);
      var e = c * Math.sin(a * Math.PI / 180);
      var f = c * Math.cos(a * Math.PI / 180) * Math.sin(b * Math.PI / 180);
      return {
        x: d,
        y: e,
        z: f
      }
    },
    doZoom: function (a) {
      var b = this;
      a *= -1;
      var c = a * (b.camera.position.z / 7) + b.camera.position.z;
      var d = b.scaleContainer.scale.z;
      var e = a * (d / 3) + d;
      if (e < b.options.globeMinScale) e = b.options.globeMinScale;
      if (e > b.options.globeMaxScale) e = b.options.globeMaxScale;
      var f = 1 / e;
      (new TWEEN.Tween(b.scaleContainer.scale)).to({
        x: e,
        y: e,
        z: e
      }, 500).easing(TWEEN.Easing.Quartic.EaseOut).start();
      if (b.options.hotspotDynamicScale === true) {
        for (var g = 0; g < b.hotspotsArr.length; g++) {
          (new TWEEN.Tween(b.hotspotsArr[g].scale)).to({
            x: -f,
            y: f,
            z: -f
          }, 500).easing(TWEEN.Easing.Quartic.EaseOut).start()
        }
      }
    },
    setupListeners: function () {
      var a = this;
      a.$elem.on("mousedown", this, a.onDocumentMouseDown);
      a.$elem.on("click", this, a.onDocumentMouseClick);
      a.$elem.mousewheel({
        me: a
      }, a.onDocumentMouseWheel)
    },
    onDocumentMouseWheel: function (a, b, c, d) {
      var e = a.data.me;
      a.preventDefault();
      // e.doZoom(b)
    },
    onDocumentMouseClick: function (a) {
      var b = a.data;
      b.checkHotspotClick()
    },
    checkHotspotClick: function () {
      var c = this;
  
      b.cancelAnimationFrame(c.animate);
      var e = mouseX / c.windowDimensionX * 2 - 1;
      var f = -(mouseY / c.windowDimensionY) * 2 + 1;
      var g = new THREE.Vector3(e, f, -1);
      var h = new THREE.Vector3(e, f, 1);
      c.projector.unprojectVector(g, c.camera);
      c.projector.unprojectVector(h, c.camera);
      h.subSelf(g).normalize();
      var i = new THREE.Ray;
      i.origin = g;
      i.direction = h;
      var j = i.intersectObjects(c.hotspotsArr);
      if (j.length > 0) {
        var k = a(c.hotspotDivsArr[j[0].object.name]).data("popwidth");
        k = k != d ? k : c.options.popWidth;
        var l = a(c.hotspotDivsArr[j[0].object.name]).data("popheight");
        l = l != d ? l : c.options.popHeight;
        if (a(c.hotspotDivsArr[j[0].object.name]).data("url") == "") {
          a.colorbox({
            html: a(c.hotspotDivsArr[j[0].object.name]).html(),
            width: k,
            height: l
          })
        } else {
          a.colorbox({
            href: a(c.hotspotDivsArr[j[0].object.name]).data("url"),
            iframe: true,
            width: k,
            height: l
          })
        }
      }
    },
    onDocumentMouseDown: function (b) {
      b.preventDefault();
      var d = b.data;
      d.mouseDown = true;
      mouseY = b.pageY - d.$elem.offset().top;
      mouseX = b.pageX - d.$elem.offset().left;
      d.$elem.on("mousemove", d, d.onDocumentMouseMove);
      a(c).on("mouseup", d, d.onDocumentMouseUp);
      mouseXOnMouseDown = b.clientX - d.windowDimensionX;
      targetRotationOnMouseDown_x = d.targetRotation_x;
      mouseYOnMouseDown = b.clientY - d.windowDimensionY;
      targetRotationOnMouseDown_y = d.targetRotation_y
    },
    onDocumentMouseMove: function(a){
      var b = a.data;
      mouseX = a.clientX - b.windowDimensionX;
      b.targetRotation_x = targetRotationOnMouseDown_x + (mouseX - mouseXOnMouseDown) * .02;
      mouseY = a.clientY - b.windowDimensionY;
      b.targetRotation_y = targetRotationOnMouseDown_y + (mouseY - mouseYOnMouseDown) * .02
    },
    onDocumentMouseUp: function(b){
      var d = b.data;
      d.mouseDown = false;
      d.$elem.off("mousemove", d.onDocumentMouseMove);
      a(c).off("mouseup", d.onDocumentMouseUp)
    },
    animate: function () {
      this.animationHandler = requestAnimationFrame(this.animate.bind(this));
      var a = this;
      if (a.targetRotation_y < -5) {
        a.targetRotation_y = -5
      }
      if (a.targetRotation_y > 5) {
        a.targetRotation_y = 5
      }
      a.globeContainer.rotation.y += (.35 * a.targetRotation_x - a.globeContainer.rotation.y) * .2;
      a.globeContainerParent.rotation.x += (.35 * a.targetRotation_y - a.globeContainerParent.rotation.x) * .2;
      TWEEN.update();
      a.render();
      if (a.options.debugMode === true) {
        a.stats.update()
      }
    },
    render: function () {
      var a = this;
      a.renderer.render(a.scene, a.camera)
    }
  }
})(jQuery, window, document)