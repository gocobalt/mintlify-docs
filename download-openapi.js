// Makes the "Download the OpenAPI spec" card download the file instead of
// opening the raw YAML in a browser tab. Mintlify auto-includes any root-level
// .js file on every page.
//
// The card links to the raw spec on the permanent `main` branch, so once this
// is merged to production the download resolves for everyone. GitHub raw sends
// permissive CORS headers, so we fetch it into a Blob and trigger a real
// download named refold-public-api.yaml. A delegated listener survives SPA
// navigation; on any failure we open the URL so the link is never dead.
(function () {
  var SPEC_MATCH = "openapi.yaml"; // any anchor whose href points at the spec
  var FILENAME = "refold-public-api.yaml";

  function findSpecAnchor(node) {
    while (node && node !== document.body) {
      if (node.tagName === "A") {
        var href = node.getAttribute("href") || "";
        if (href.indexOf(SPEC_MATCH) !== -1) return node;
      }
      node = node.parentElement;
    }
    return null;
  }

  document.addEventListener(
    "click",
    function (e) {
      var a = findSpecAnchor(e.target);
      if (!a) return;
      var url = a.getAttribute("href");
      if (!url) return;

      e.preventDefault();
      e.stopPropagation();

      fetch(url)
        .then(function (r) {
          if (!r.ok) throw new Error("status " + r.status);
          return r.blob();
        })
        .then(function (blob) {
          var objUrl = URL.createObjectURL(blob);
          var dl = document.createElement("a");
          dl.href = objUrl;
          dl.download = FILENAME;
          dl.rel = "noopener";
          document.body.appendChild(dl);
          dl.click();
          dl.remove();
          setTimeout(function () {
            URL.revokeObjectURL(objUrl);
          }, 1000);
        })
        .catch(function () {
          window.open(url, "_blank", "noopener");
        });
    },
    true
  );
})();
