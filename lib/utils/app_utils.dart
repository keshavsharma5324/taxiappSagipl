enum OTPForType {
  Registration,
  ForgotPassword,
  UpdateProfilePhone,
  UpdateProfileEmail
}

const Map<OTPForType, int> OTPForTypeValue = {
  OTPForType.Registration: 0,
  OTPForType.ForgotPassword: 1,
  OTPForType.UpdateProfilePhone: 2,
  OTPForType.UpdateProfileEmail: 3
};

//SendOtp(user_type)
enum UserType { Passenger, Driver }

const Map<UserType, int> UserTypeValue = {
  UserType.Passenger: 0,
  UserType.Driver: 1,
}; //UserTypeValue[UserType.Passenger]

//update profile constant here...
//type(Under update_profile)
enum UpdateProfilePic {
  PicUrl,
  TaxiLicensePicUrlFront,
  TaxiLicensePicUrlBack,
  TaxiRegistrationPicUrlFront,
  TaxiRegistrationPicUrlBack,
  ConsentLetter
}

const Map<UpdateProfilePic, int> UpdateProfilePicValue = {
  UpdateProfilePic.PicUrl: 0,
  UpdateProfilePic.TaxiLicensePicUrlFront: 1,
  UpdateProfilePic.TaxiLicensePicUrlBack: 2,
  UpdateProfilePic.TaxiRegistrationPicUrlFront: 3,
  UpdateProfilePic.TaxiRegistrationPicUrlBack: 4,
  UpdateProfilePic.ConsentLetter: 5,
};

//status(Under available_mode) -> Online = 0, Offline = 1, Booked = 2
enum Status { Online, Offline, Booked }

const Map<Status, int> StatusValue = {
  Status.Online: 0,
  Status.Offline: 1,
  Status.Booked: 2
};
