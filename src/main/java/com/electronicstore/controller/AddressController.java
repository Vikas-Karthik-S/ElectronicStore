package com.electronicstore.controller;

import com.electronicstore.model.Address;
import com.electronicstore.model.User;
import com.electronicstore.service.AddressService;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/addresses")
public class AddressController extends HttpServlet {
    private AddressService addressService = new AddressService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Address> addresses = addressService.getUserAddresses(user.getId());
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("/pages/addresses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                // Verify ownership implicitly or assume logged in user owns it (could be improved)
                Address addr = addressService.getAddressById(id);
                if (addr != null && addr.getUserId() == user.getId()) {
                    if (addressService.deleteAddress(id)) {
                        response.sendRedirect(request.getContextPath() + "/addresses?msg=Address removed successfully");
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/addresses?error=Failed to remove address");
            return;
        }

        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");
        boolean isDefault = request.getParameter("isDefault") != null;

        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Address updateAddress = addressService.getAddressById(id);
                if (updateAddress != null && updateAddress.getUserId() == user.getId()) {
                    updateAddress.setStreet(street);
                    updateAddress.setCity(city);
                    updateAddress.setState(state);
                    updateAddress.setZipCode(zipCode);
                    updateAddress.setCountry(country);
                    updateAddress.setDefault(isDefault);
                    if (addressService.updateAddress(updateAddress)) {
                        response.sendRedirect(request.getContextPath() + "/addresses?msg=Address updated successfully");
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/addresses?error=Failed to update address");
            return;
        }

        Address newAddress = new Address();
        newAddress.setUserId(user.getId());
        newAddress.setStreet(street);
        newAddress.setCity(city);
        newAddress.setState(state);
        newAddress.setZipCode(zipCode);
        newAddress.setCountry(country);
        newAddress.setDefault(isDefault);

        if (addressService.addAddress(newAddress)) {
            response.sendRedirect(request.getContextPath() + "/addresses?msg=Address added successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/addresses?error=Failed to add address");
        }
    }
}
