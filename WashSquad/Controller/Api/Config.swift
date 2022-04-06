//
//  Config.swift
//  HandBreak
//
//  Created by Ghoost on 7/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.

// xxx https://documenter.getpostman.com/view/11297871/UVkgyesX#9e2a2027-2179-4580-b22b-dca1c50489d8 xxx
// https://documenter.getpostman.com/view/11297871/UVkgyesX#ddea1864-7122-41c3-9c0d-29538d6a3db4

import Foundation



let mainURL = "http://test.washsquadsa.com/api/"
//let mainURL = "https://washsquadsa.com/api/"
let imageURL =  "http://washsquadsa.com/upload/"
let visitUrl = mainURL + "visit"
let registerUrl = mainURL + "client/register"
let loginUrl = mainURL + "client/login"
let sendCodeUrl = mainURL + "client/code/send"
let confirmcode = mainURL + "client/cofirm-code"
let allservicesUrl = mainURL + "services"
let carSizesUrl = mainURL + "carSizes"
let OffersUrl = mainURL + "offers"
let getCarTypes = mainURL + "carTypes"
let alltimesUrl = mainURL + "workTimes"
let couponCheck = mainURL + "coupon/check"
let makeOrderUrl = mainURL + "order/add"
let getMyOrdersUrl = mainURL + "orders"
let updateMyProfileUrl = mainURL + "profile/edit"
let orderRating = mainURL + "order/rate"
let questionsUrrl = mainURL + "questions"
let termsUrl = mainURL + "about-us"
let logOutUrl = mainURL + "client/logout"
let contactUrl = mainURL + "contact-us"
let getPriceUrl = mainURL + "getPrice"
let passwordChangeUrl = mainURL + "client/password/change"
let frogetPassUrl = mainURL + "client/password/forget"

let userSubscriptionURL = mainURL + "order/getSubscription?user_id=\(support.getuserId)"
let updateSubscriptionURL = mainURL + "order/update-subscription"
let allSettingURL = mainURL + "all-social"
let profileURL = mainURL + "client/profile"

let singleServiceURL = mainURL + "single/service"
let settingURL = mainURL + "setting"
let placesURL = mainURL + "places"
let timeByDateURL = mainURL + "date/get/times"
