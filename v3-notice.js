// Shows an "in progress" notice on v3 documentation pages only.
// Mintlify auto-includes any root-level .js file on every page, so this runs
// globally; it scopes itself to /v3/* routes and re-checks on SPA navigation.
(function () {
  var BANNER_ID = "rf-v3-notice";
  var DISMISS_KEY = "rf-v3-notice-dismissed";

  function onV3() {
    var seg = window.location.pathname.split("/").filter(Boolean)[0];
    return seg === "v3";
  }

  function remove() {
    var el = document.getElementById(BANNER_ID);
    if (el) el.remove();
    document.documentElement.classList.remove("rf-has-v3-notice");
  }

  function render() {
    try {
      if (!onV3() || sessionStorage.getItem(DISMISS_KEY) === "1") {
        remove();
        return;
      }
      if (document.getElementById(BANNER_ID) || !document.body) return;

      var bar = document.createElement("div");
      bar.id = BANNER_ID;
      bar.setAttribute("role", "status");
      bar.innerHTML =
        '<span class="rf-v3-notice__text">' +
        '<strong>Heads up:</strong> the v3 documentation is in progress and may change. ' +
        'View the <a href="/legacy/overview">v2 docs</a> for stable content, or ' +
        '<a href="https://www.refold.ai/contact-us">contact our support team</a>.' +
        "</span>" +
        '<button type="button" class="rf-v3-notice__close" aria-label="Dismiss notice">&times;</button>';
      document.body.appendChild(bar);
      document.documentElement.classList.add("rf-has-v3-notice");

      bar.querySelector(".rf-v3-notice__close").addEventListener("click", function () {
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
