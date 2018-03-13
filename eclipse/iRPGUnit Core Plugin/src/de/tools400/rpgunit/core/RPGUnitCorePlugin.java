/*******************************************************************************
 * Copyright (c) 2013-2016 iRPGUnit Project Team
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Common Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/cpl-v10.html
 *******************************************************************************/

package de.tools400.rpgunit.core;

import org.eclipse.core.runtime.Status;
import org.eclipse.jface.preference.IPreferenceStore;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.resource.ImageRegistry;
import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;

/**
 * The activator class controls the plug-in life cycle
 */
public class RPGUnitCorePlugin extends AbstractUIPlugin {

    public static final String IMAGE_ERROR = "error"; //$NON-NLS-1$

    public static final String IMAGE_ASSERTION = "assertion"; //$NON-NLS-1$

    public static final String IMAGE_FAILURE = "failure"; //$NON-NLS-1$

    public static final String IMAGE_TEST_ERROR = "test_error"; //$NON-NLS-1$

    public static final String IMAGE_TEST_FAILED = "test_failed"; //$NON-NLS-1$

    public static final String IMAGE_TEST_SUCCESS = "test_success"; //$NON-NLS-1$

    // The plug-in ID
    public static final String PLUGIN_ID = "de.tools400.rpgunit.core"; //$NON-NLS-1$

    // The shared instance
    private static RPGUnitCorePlugin plugin;

    /**
     * The constructor
     */
    public RPGUnitCorePlugin() {
        return;
    }

    /*
     * (non-Javadoc)
     * @see org.eclipse.ui.plugin.AbstractUIPlugin#start(org.osgi.framework.
     * BundleContext )
     */
    @Override
    public void start(BundleContext context) throws Exception {
        super.start(context);
        plugin = this;
    }

    /*
     * (non-Javadoc)
     * @see org.eclipse.ui.plugin.AbstractUIPlugin#stop(org.osgi.framework.
     * BundleContext )
     */
    @Override
    public void stop(BundleContext context) throws Exception {
        plugin = null;
        super.stop(context);
    }

    /**
     * Returns the shared instance
     * 
     * @return the shared instance
     */
    public static RPGUnitCorePlugin getDefault() {
        return plugin;
    }

    public static IPreferenceStore getPreferencesStore() {
        return getDefault().getPreferenceStore();
    }

    /**
     * Returns the version of the plugin, as assigned to "Bundle-Version" in
     * "MANIFEST.MF".
     * 
     * @return Version of the plugin.
     */
    public String getVersion() {
        String version = (String)getBundle().getHeaders().get(Constants.BUNDLE_VERSION);
        if (version == null) {
            version = "0.0.0"; //$NON-NLS-1$
        }

        // try {
        // Pattern pattern = Pattern
        // .compile("^([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})(?:\\.v[0-9]{0,12})?");
        // Matcher matcher = pattern.matcher(version);
        // if (matcher.find()) {
        // version = matcher.group(1);
        // }
        // } catch (Throwable e) {
        // // Ignore errors and return original version string
        // }

        return version;
    }

    /**
     * Convenience method to log informational messages to the application log.
     * 
     * @param message Message
     */
    public static void logInfo(String message) {
        plugin.getLog().log(new Status(Status.INFO, PLUGIN_ID, message));
    }

    /**
     * Convenience method to log error messages to the application log.
     * 
     * @param message Message
     */
    public static void logError(String message) {
        logError(message, null);
    }

    /**
     * Convenience method to log error messages to the application log.
     * 
     * @param message Message
     * @param e The exception that has produced the error
     */
    public static void logError(String message, Exception e) {
        plugin.getLog().log(new Status(Status.ERROR, PLUGIN_ID, Status.ERROR, "RPGUnit: " + message, e)); //$NON-NLS-1$
    }

    /**
     * Returns an image descriptor for the image file at the given plug-in
     * relative path
     * 
     * @param path the image path
     * @return the image descriptor
     */
    public static ImageDescriptor getImageDescriptor(String path) {
        return imageDescriptorFromPlugin(PLUGIN_ID, path);
    }

    /*
     * (non-Javadoc)
     * @see org.eclipse.ui.plugin.AbstractUIPlugin#initializeImageRegistry(org.
     * eclipse .jface.resource.ImageRegistry)
     */
    @Override
    protected void initializeImageRegistry(ImageRegistry reg) {
        super.initializeImageRegistry(reg);

        // add images
        reg.put(IMAGE_TEST_SUCCESS, getImageDescriptor("icons/test_success16.gif")); //$NON-NLS-1$
        reg.put(IMAGE_TEST_FAILED, getImageDescriptor("icons/test_failed16.gif")); //$NON-NLS-1$
        reg.put(IMAGE_TEST_ERROR, getImageDescriptor("icons/test_error16.gif")); //$NON-NLS-1$

        reg.put(IMAGE_ASSERTION, getImageDescriptor("icons/assertions16.png")); //$NON-NLS-1$
        reg.put(IMAGE_FAILURE, getImageDescriptor("icons/failure16.png")); //$NON-NLS-1$
        reg.put(IMAGE_ERROR, getImageDescriptor("icons/error16.png")); //$NON-NLS-1$

        // additional icons used in 'plugin.xml':
        // --------------------------------------
        // collapse_all16.png
        // delete_testcase16.png
        // disable_report.png
        // edit16.gif
        // enable_debug.png
        // expand_all16.png
        // rerun16.gif
        // rpgunit16.png
        // run16.gif
        // toggle16.png
    }
}
