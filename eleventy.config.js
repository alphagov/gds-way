const govukEleventyPlugin = require('@x-govuk/govuk-eleventy-plugin')
const pluginTOC = require('eleventy-plugin-toc')

var createNavItem = function (headingItem) {
  return {
    current: false,
    href: "#" + headingItem.id,
    text: headingItem.text,
    parent: headingItem.children ? true : false,
    children: headingItem.children
      ? headingItem.children.map((child) => createNavItem(child))
      : false
  }
};

module.exports = function(eleventyConfig) {
  // Register the plugin
  eleventyConfig.addPlugin(govukEleventyPlugin, {
    footer: {
      meta: {
        items: [
          {
            href: "/accessibility/",
            text: "Accessibility"
          }
        ]
      }
    }
  })
  eleventyConfig.setNunjucksEnvironmentOptions({
    // this has no effect as is overridden entirely by govuk-eleventy-plugin :(
	});
  eleventyConfig.addFilter("toc", (content) => {
    if (content) {
      var debug = require('debug')('myfilter')

      const cheerio = require('cheerio')
      // TODO refactor into new plugin?
      const NestHeadings = require('eleventy-plugin-toc/src/NestHeadings')
      
      const tags = ['h2', 'h3', 'h4']
      const $ = cheerio.load(content)
      
      headings = NestHeadings(tags, $)

      const items = []
      headings.forEach((item) => {
        const navItem = createNavItem(item)
        items.push(navItem)
      })
      return items
    }
  });


  return {
    dataTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
    markdownTemplateEngine: 'njk',
    dir: {
      // The folder where all your content will live:
      input: 'source',
    }
  }
};
