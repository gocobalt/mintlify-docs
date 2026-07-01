// Adds a "Download as Markdown" icon button next to Mintlify's per-page
// "Copy page" control, and hides the redundant "Copy page" row inside its
// dropdown. Mintlify has no native download-markdown option and auto-includes
// any root-level .js file. This depends on Mintlify's header DOM (unsupported),
// so every step is guarded: a miss is a silent no-op, never a broken page.
(function () {
  var BTN_ID = "rf-download-md";
  var LABEL = "Download as Markdown";
  var injecting = false;

  // Lucide "file-down" icon.
  var ICON =
    '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" ' +
    'viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" ' +
    'stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
    '<path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7z"/>' +
    '<polyline points="14 2 14 8 20 8"/>' +
    '<path d="M12 18v-6"/>' +
    '<path d="m9 15 3 3 3-3"/></svg>';

  // Mintlify serves every page's raw markdown at "<path>.md".
  function download() {
    try {
      var path = window.location.pathname.replace(/\/+$/, "") || "/index";
      var parts = window.location.pathname.split("/").filter(Boolean);
      var a = document.createElement("a");
      a.href = path + ".md";
      a.download = (parts[parts.length - 1] || "page") + ".md";
      a.rel = "noopener";
      document.body.appendChild(a);
      a.click();
      a.remove();
    } catch (e) {}
  }

  // The always-visible "Copy page" button in the page header.
  function findCopyButton() {
    var els = document.querySelectorAll("button, a");
    for (var i = 0; i < els.length; i++) {
      var t = (els[i].textContent || "").trim().toLowerCase();
      if (t === "copy page" || t.indexOf("copy page") === 0) return els[i];
    }
    return null;
  }

  // The pill group holding the copy button and dropdown chevron (nearest
  // ancestor with 2+ clickable children).
  function findGroup(copyBtn) {
    var g = copyBtn.parentElement;
    while (g && g.parentElement) {
      if (g.querySelectorAll("button, a").length >= 2) return g;
      g = g.parentElement;
    }
    return copyBtn.parentElement || copyBtn;
  }

  // Flip any clipping ancestor to visible so the button's border isn't trimmed
  // where it overflows the header actions container.
  function unclip(el) {
    var node = el.parentElement;
    for (var i = 0; node && node !== document.body && i < 5; i++) {
      try {
        var cs = getComputedStyle(node);
        if (cs.overflowX === "hidden" || cs.overflowX === "clip") node.style.overflowX = "visible";
        if (cs.overflow === "hidden" || cs.overflow === "clip") node.style.overflow = "visible";
      } catch (e) {}
      node = node.parentElement;
    }
  }

  function inject() {
    if (injecting || document.getElementById(BTN_ID)) return;
    var copyBtn = findCopyButton();
    if (!copyBtn) return;
    var group = findGroup(copyBtn);
    if (!group || !group.parentNode) return;

    injecting = true;
    try {
      // Shallow clone inherits the button's theme classes (colors, hover); we
      // swap in an icon and override geometry/border below.
      var btn = copyBtn.cloneNode(false);
      btn.id = BTN_ID;
      btn.innerHTML = ICON;
      btn.setAttribute("aria-label", LABEL);
      btn.setAttribute("title", LABEL);
      btn.removeAttribute("aria-haspopup");
      btn.removeAttribute("aria-expanded");
      if (btn.tagName === "A") {
        btn.removeAttribute("href");
        btn.removeAttribute("target");
      }

      // The cloned copy button is the left half of a split pill (no right
      // border), so give this standalone square its own full border, colored
      // from the pill to match light/dark mode.
      var border = "";
      try {
        border = getComputedStyle(group).borderTopColor;
        if (!border || border === "rgba(0, 0, 0, 0)") border = getComputedStyle(copyBtn).borderTopColor;
      } catch (e) {}
      if (!border || border === "rgba(0, 0, 0, 0)") border = "rgba(128,128,128,0.35)";

      var h = group.offsetHeight || copyBtn.offsetHeight || 36;
      btn.removeAttribute("style");
      btn.style.cssText =
        "box-sizing:border-box;padding:0;min-width:0;flex:0 0 auto;" +
        "display:inline-flex;align-items:center;justify-content:center;" +
        "align-self:center;border-radius:8px;margin-left:8px;" +
        "width:" + h + "px;height:" + h + "px;border:1px solid " + border + ";";

      btn.addEventListener(
        "click",
        function (e) {
          e.preventDefault();
          e.stopPropagation();
          download();
        },
        true
      );

      group.parentNode.insertBefore(btn, group.nextSibling); // right of the pill
      unclip(btn);
    } catch (e) {
    } finally {
      injecting = false;
    }
  }

  // The main split button already copies, so hide the duplicate "Copy page"
  // row in the dropdown (any "Copy page" element outside the pill group).
  function stripDropdownCopy() {
    try {
      var copyBtn = findCopyButton();
      var group = copyBtn ? findGroup(copyBtn) : null;
      var els = document.querySelectorAll('a, button, [role="menuitem"]');
      for (var i = 0; i < els.length; i++) {
        var el = els[i];
        if (el.id === BTN_ID) continue;
        var t = (el.textContent || "").trim().toLowerCase();
        if (t !== "copy page" && t.indexOf("copy page") !== 0) continue;
        if (group && group.contains(el)) continue; // the main split button
        (el.closest('[role="menuitem"]') || el).style.display = "none";
      }
    } catch (e) {}
  }

  // Re-run on any DOM change (SPA navigation, dropdown open), debounced.
  var scheduled = false;
  function schedule() {
    if (scheduled) return;
    scheduled = true;
    (window.requestAnimationFrame || window.setTimeout)(function () {
      scheduled = false;
      inject();
      stripDropdownCopy();
    }, 0);
  }

  function start() {
    if (!document.body) return;
    try {
      new MutationObserver(schedule).observe(document.body, { childList: true, subtree: true });
    } catch (e) {
      setInterval(schedule, 500);
    }
    schedule();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start);
  } else {
    start();
  }
})();
