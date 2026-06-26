// Shows a notice on v2 (legacy) documentation pages pointing users to v3 for
// API references, SDKs, and the changelog, which are no longer in v2.
// Mintlify auto-includes any root-level .js file on every page, so this runs
// globally; it scopes itself to /legacy/* routes and re-checks on SPA navigation.
(function () {
  var BANNER_ID = "rf-v2-notice";
  var DISMISS_KEY = "rf-v2-notice-dismissed";

  function onLegacy() {
    var seg = window.location.pathname.split("/").filter(Boolean)[0];
    return seg === "legacy";
  }

  function remove() {
    var el = document.getElementById(BANNER_ID);
    if (el) el.remove();
    document.documentElement.classList.remove("rf-has-v2-notice");
  }

  function render() {
    try {
      if (!onLegacy() || sessionStorage.getItem(DISMISS_KEY) === "1") {
        remove();
        return;
      }
      if (document.getElementById(BANNER_ID) || !document.body) return;

      var bar = document.createElement("div");
      bar.id = BANNER_ID;
      bar.setAttribute("role", "status");
      bar.innerHTML =
        '<span class="rf-v2-notice__text">' +
        '<strong>Looking for API references, SDKs, or the changelog?</strong> ' +
        'They now live in the v3 docs. View the ' +
        '<a href="/v3/api-reference/overview">v3 API reference &amp; SDKs</a> or the ' +
        '<a href="/v3/changelog/overview">v3 changelog</a>.' +
        "</span>" +
        '<button type="button" class="rf-v2-notice__close" aria-label="Dismiss notice">&times;</button>';
      document.body.appendChild(bar);
      document.documentElement.classList.add("rf-has-v2-notice");

      bar.querySelector(".rf-v2-notice__close").addEventListener("click", function () {
        try { sessionStorage.setItem(DISMISS_KEY, "1"); } catch (e) {}
        remove();
      });
    } catch (e) {
      /* never break the page */
    }
  }

  // Initial render
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", render);
  } else {
    render();
  }

  // Re-render on client-side (SPA) navigation
  ["pushState", "replaceState"].forEach(function (m) {
    var orig = history[m];
    if (typeof orig === "function") {
      history[m] = function () {
        var r = orig.apply(this, arguments);
        window.dispatchEvent(new Event("rf:locationchange"));
        return r;
      };
    }
  });
  window.addEventListener("popstate", function () {
    window.dispatchEvent(new Event("rf:locationchange"));
  });
  window.addEventListener("rf:locationchange", render);

  // Fallback poll in case navigation happens without history hooks firing
  var lastPath = window.location.pathname;
  setInterval(function () {
    if (window.location.pathname !== lastPath) {
      lastPath = window.location.pathname;
      render();
    }
  }, 500);
})();
