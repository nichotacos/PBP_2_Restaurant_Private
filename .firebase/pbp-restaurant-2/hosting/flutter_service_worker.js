'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "20488f60f1eb6864fc4fd570d4230891",
"assets/AssetManifest.json": "eee80cd78ae42154ef227d4790e8f01c",
"assets/assets/icons/facebook.png": "8a894320475a9ddac91d6751966d5425",
"assets/assets/icons/google.png": "288a7f904219c0eef4e4ccde8c0b8e58",
"assets/assets/ilustrations/ilustration-1.png": "ce4beaaec99080862f570bdd90dd4f06",
"assets/assets/ilustrations/ilustration-2.png": "76a1e4f0cdbb4334122a4e8a9c32a312",
"assets/assets/ilustrations/pattern.png": "c1c135dfc77620f455d0908f866a7eb1",
"assets/assets/images/appBarView_images/Burger.jpeg": "1795eb4b0b0bbde80bd6ce1d8d86dc6f",
"assets/assets/images/appBarView_images/EsJeruk.jpeg": "dca8b9f1e6c387c002a2d1efc9ded9c6",
"assets/assets/images/appBarView_images/EsTeh.jpeg": "391bfee4df0f5bfa0f609522a597451a",
"assets/assets/images/appBarView_images/FrenchFries.jpeg": "fcb7d9d3060416bf4434071c2f6dd15f",
"assets/assets/images/appBarView_images/Pizza.jpeg": "34d12239d9539f9779619b3a1e07960d",
"assets/assets/images/appBarView_images/PrettyDog.jpeg": "b3e11e9b1d28b87cfdcdbd374ac405d4",
"assets/assets/images/appBarView_images/Spaghetti.jpeg": "0b4ee6f87bf7bc554ec4afce75a1c243",
"assets/assets/images/Banner-Home.png": "b4841397af91e0d4cf6be8a75937a04b",
"assets/assets/images/burger/beef-burger-deluxe.png": "0184af6ced926ee3df3b32b04f36888e",
"assets/assets/images/burger/beef-burger.png": "2d745479414ded9f3ef89af9e6d079b4",
"assets/assets/images/burger/bigmac.png": "6aca2d617eb24d4cdbab9d5ab305b9c4",
"assets/assets/images/burger/cheeseburger-deluxe.png": "98e2c89e9b19d85e859ea61220715f4c",
"assets/assets/images/burger/cheeseburger.png": "63666b72e452f5e5a5ed94bde1b0823f",
"assets/assets/images/burger/chicken-muffin-with-egg.png": "38c8b30fe96d6857c322182e2b93d06c",
"assets/assets/images/burger/chicken-muffin.png": "a82f2c2c35589918252666e80b3031cf",
"assets/assets/images/burger/egg-and-cheese-muffin.png": "332810c505c53dbdb412d6a67c320581",
"assets/assets/images/categories/cat-chicken.png": "421d84f689311f886178003f8f94be1c",
"assets/assets/images/categories/cat-drinks.jpeg": "1553466b2c0c03b57dcd50f9c60623a0",
"assets/assets/images/Dessert.png": "ded143c2e18b82c3f6ea19fceba5a0a6",
"assets/assets/images/Drink.png": "6bd78163df66f02bbd9d6231dfe11ae6",
"assets/assets/images/etc/rica-chicken-rice.png": "e229d4dc613a986e1c5ed7e234bd327a",
"assets/assets/images/Humberger.png": "3889bfffe6abc726368488c2ada21bef",
"assets/assets/images/images1.jpg": "4b5386b78f5d4c07a0080b7377c9f8a6",
"assets/assets/images/images2.jpg": "4d0a1cf64e737b576b607a62baa9ab6f",
"assets/assets/images/Meat.png": "8bbb7b1ff226d0668d0cd39e47d32a2e",
"assets/assets/images/Noodles.png": "1e415fa09ebbd858005189232258d2ce",
"assets/assets/images/Pizza.png": "9e39b6fe4560f3aa53d896d30950d856",
"assets/assets/images/Salad.png": "441ece38fd5d762eccdb7d3983890f40",
"assets/assets/images/Snack.png": "3f50efbc66d852647f973bbf6ed95281",
"assets/assets/images/test.jpeg": "a9d607a8673a06d791b3ae56000d37bb",
"assets/assets/splash/splash_image.png": "533392b993584be1c5189fae7851d66a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b0d81e8f053761d69c5b6a5fdb6694e2",
"assets/NOTICES": "32b98694f7c107d25428d604220e9879",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "c0a9fee4163870327cfc4c8d71c85e65",
"assets/packages/fluttertoast/assets/toastify.css": "910ddaaf9712a0b0392cf7975a3b7fb5",
"assets/packages/fluttertoast/assets/toastify.js": "18cfdd77033aa55d215e8a78c090ba89",
"assets/packages/toast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/toast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9c57f295a79d012dca965ce2cf4a1525",
"/": "9c57f295a79d012dca965ce2cf4a1525",
"main.dart.js": "80b3f118f6de7c2c92c4a4916846b2c7",
"manifest.json": "32fe0704b5d7784ab4fac246a2263662",
"version.json": "0702ab834a506ca873c3bf0319e5b7e7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
