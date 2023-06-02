/*
module.exports = function(markdown, options) {
  x = markdown.replace(/<!--frag-->/g, '<!-- .element class="fragment" data-auto-animate -->');
  r = x.replace(/<!--red-->/g, '<!-- .element data-auto-animate style="color:#f92f60;" -->');
  a = r.replace(/<!--rev-->/g, revision);
  u = a.replace(/<!--version-->/g, version);
  return u.replace(/<!--fit-->/g, '<!-- .element: class="r-fit-text" -->');
}
*/

module.exports = function(markdown, options) {

  revision = require('child_process').execSync('git rev-parse HEAD').toString().trim().substring(0, 9);
  version= require('child_process').execSync('type -p reveal-md').toString().trim()
  nix= require('child_process').execSync("nix --version").toString().trim().replace(" (Nix) ", " ")


  mapping = {
    "<!--red-->" : '<!-- .element data-auto-animate style="color:#f92f60;" -->',
    "<!--frag-->" : '<!-- .element class="fragment" data-auto-animate -->',
    "<!--fit-->" :  '<!-- .element: class="r-fit-text" -->',
    "<!--rev-->" :  revision,
    "<!--nix-->" :  nix,
    "<!--left-->" :  '<div id="left">',
    "<!--right-->" :  '<div id="right">',
    "<!--div-->" :  '</div>',
    "<!--slideani-->" : '<!-- .slide: data-auto-animate -->',
    "<!--version-->" :  version
  };

  for (let key in mapping) {
    v = mapping[key]
    markdown = markdown.replace(new RegExp(`${key}`, 'g'), v);
  }
  return markdown
}
