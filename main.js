const puppeteer = require('puppeteer');

async function main(args) {
  const browser = await puppeteer.launch({
    args: [
      '--no-sandbox',
    ],
  });
  try {
    const version = await browser.version();
    return { 
      msg: `Hello ${args.name}! version = ${version}!`
    };
  } finally {
    await browser.close();
  }
}