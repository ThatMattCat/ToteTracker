# ToteTracker

## Work-In-Progress

This is in a "good enough" state to be used for it's purpose but has plenty of quirks and needs UI/UX improvements

## Overview

A storage tracking application for Android devices. Creates a local SQLite DB on the device containing a list of all storage containers and their contents, for easy tracking.

Built with FlutterFlow

## Getting Started

Functionality includes:

* Allows uploading the Database to default device 'share' options for backup and retrieval
* AI image analysis to automatically name & classify objects being stored
  * A Gemini API key must be provided in the settings in order for this to function properly
* Alternative to AI: Uses [UPCItemDB API](https://www.upcitemdb.com/) to get item details from scanned barcodes
* Item images stored as base64-encoded strings, directly in the database
* Scans stickers created by the [QR Sticker Generator](https://github.com/ThatMattCat/qr-sticker-generator) to keep track of storage containers

<table>
  <tr>
    <td><img src="media/homepage.jpg" width="200" height="400"></td>
    <td><img src="media/container-contents.jpg" width="200" height="400"></td>
    <td><img src="media/item-search.jpg" width="200" height="400"></td>
    <td><img src="media/new-item.jpg" width="200" height="400"></td>
  </tr>
 <tr>
  <td><img src="media/settings.jpg" width="200" height="400"></td>
 </tr>
</table>
