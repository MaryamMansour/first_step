class ApiConstants {
  static const String apiBaseUrl = "https://first-step.azurewebsites.net/rest/";
  static const String login = "auth/login";
  static const String signup = "auth/signup";
  static const String profile = "profile";
  static const String resetPassword = "profile/reset-password";

  static const String openAiBaseUrl = 'https://chatgpt-api.shn.hk/v1/';
  static const String openAiCompletion = '';
  static const String GEMINI_API_KEY = "AIzaSyBsY__QnFC3le7r-P-FB5K9OdViM99HwXw";

  static const String getAllProjects = "project/all";
  static const String uploadProjects = "project/upload";


}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}