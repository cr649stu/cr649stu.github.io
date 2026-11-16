/* 作品页：配置了 Supabase 时从数据库读取作品；读不到就保留 HTML 里的静态内容。 */
(function () {
  "use strict";

  var cfg = window.SITE_CONFIG || {};
  if (!cfg.url || !cfg.anonKey) return;

  var list = document.getElementById("worksList");
  var nav = document.getElementById("worksIndex");
  var count = document.getElementById("worksCount");
  if (!list) return;

  function esc(s) {
    return String(s == null ? "" : s)
      .replace(/&/g, "&amp;").replace(/</g, "&lt;")
      .replace(/>/g, "&gt;").replace(/"/g, "&quot;");
  }
  function pad(n) { return n < 10 ? "0" + n : String(n); }

  function render(rows) {
    if (nav) {
      nav.innerHTML = rows.map(function (w, i) {
        var shortName = String(w.title || "").split(" · ")[0];
        return '<a href="#p' + (i + 1) + '">' + pad(i + 1) + " " + esc(shortName) + "</a>";
      }).join("");
    }

    list.innerHTML = rows.map(function (w, i) {
      var tags = (w.tags || []).map(function (t) { return "<li>" + esc(t) + "</li>"; }).join("");
      var links = "";
      if (w.demo_url) {
        links += '<a class="work-link" href="' + esc(w.demo_url) + '">' + esc(w.demo_label || "打开 →") + "</a>";
      }
      if (w.source_url) {
        links += '<a class="work-link" href="' + esc(w.source_url) + '" target="_blank" rel="noopener">查看源码 →</a>';
      }
      return '<article class="work' + (w.wide ? " work-wide" : "") + '" id="p' + (i + 1) + '">' +
        '<span class="work-index">' + pad(i + 1) + "</span>" +
        "<h2>" + esc(w.title) + "</h2>" +
        "<p>" + esc(w.summary) + "</p>" +
        (tags ? '<ul class="work-tags">' + tags + "</ul>" : "") +
        (w.hard_note ? '<p class="work-hard"><b>难点</b>' + esc(w.hard_note) + "</p>" : "") +
        links +
      "</article>";
    }).join("");

    if (count) count.textContent = pad(rows.length);
  }

  fetch(cfg.url + "/rest/v1/works?select=*&order=sort_index.asc", {
    headers: { apikey: cfg.anonKey, Authorization: "Bearer " + cfg.anonKey }
  }).then(function (r) {
    if (!r.ok) throw new Error("load failed");
    return r.json();
  }).then(function (rows) {
    if (rows && rows.length) render(rows);
  }).catch(function () {
    /* 网络或权限问题：保留静态内容，不影响阅读 */
  });
})();
